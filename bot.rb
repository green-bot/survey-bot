#!/usr/bin/env ruby
## survey bot
#
## Summary and Configuration
# This bot asks up to ten questions of the inbound messager, then stores
# these answers.  Questions are not validated, and do not trigger any
# particular behaviors.  If a question is blank, it is not asked.
#
# [Survey bot flow chart](https://cloud.githubusercontent.com/assets/9991/15373000/3c6d6012-1d11-11e6-8a36-902716d06985.png)
## Installation
# This bot can be installed on any GreenBot server through the web UI, or
# by through the command line at the greenbot-core root with a
# a 'npm install survey-bot'
#
# This bot requires a ruby installation, 2.0 or older
#
### Annoated Bot Code - Full source in repo
require './lib/greenbot.rb' # ./lib/greenbot.rb contains helper libraries

def handle(prompt, fieldName= nil)
  # If there's nothing to tell or ask, get out of here.
  return unless prompt

  if fieldName.nil?
    # No field name, so just say it.
    tell prompt if prompt
  else
    # If there's a field name, then we are asking for something.
    # Ask and remember the answer
    answer = ask prompt
    answer.remember(fieldName)
  end
end

# Ask the first two prompts.
handle ENV['PROMPT_1']
handle ENV['PROMPT_2']

# Ask the guest for their name, if configured
# Don't use handle because we want to confirm their name
if ENV['NAME_PROMPT']
  name = confirmed_gets(ENV['NAME_PROMPT'])
  name.remember('name')
end

# For each of the ten possible questions, ask them if they are configured
# and save the answer
%w( QUESTION_1 QUESTION_2 QUESTION_3
    QUESTION_4 QUESTION_5 QUESTION_6
    QUESTION_7 QUESTION_8 QUESTION_9
    QUESTION_10 ).each { |p| handle(ENV[p], p) }

handle ENV['SIGNATURE']
