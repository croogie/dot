#!/usr/bin/env ruby

# You can generate json by executing the following command on Terminal.
#
# $ ruby ./CreateLauncherModeTemplate.json.rb
#

# Parameters

def parameters
  {
    :simultaneous_threshold_milliseconds => 500,
    :trigger_key => 'o',
  }
end

############################################################

require 'json'

def main
  data = {
    'description' => 'O-Launcher',
    'manipulators' => [
      generate_launcher_mode('k', [], [{ 'shell_command' => "open -a 'Slack'" }]),
      generate_launcher_mode('0', [], [{ 'shell_command' => "open -a 'Webstorm'" }]),
      generate_launcher_mode('9', [], [{ 'shell_command' => "open -a 'PyCharm'" }]),
      generate_launcher_mode('h', [], [{ 'shell_command' => "open -a 'Hyper'" }]),
      generate_launcher_mode('t', [], [{ 'shell_command' => "open -a 'iThoughtsX'" }]),
      generate_launcher_mode('f', [], [{ 'shell_command' => "open -a 'Finder'" }]),
      generate_launcher_mode('p', [], [{ 'shell_command' => "open -a 'Spotify'" }]),
      generate_launcher_mode('c', [], [{ 'shell_command' => "open -a 'Calendar'" }]),
      generate_launcher_mode('z', [], [{ 'shell_command' => "open -a 'zoom.us'" }]),
      generate_launcher_mode('n', [], [{ 'shell_command' => "open -a 'Notion'" }]),
      generate_launcher_mode('g', [], [{ 'shell_command' => "open -a 'Google Chrome'" }]),
      generate_launcher_mode('v', [], [{ 'shell_command' => "open -a 'Visual Studio Code'" }]),
      generate_launcher_mode('s', [], [{ 'shell_command' => "open -a 'Spark'" }]),
      generate_launcher_mode('a', [], [{ 'shell_command' => "open -a 'MarginNote 3'" }]),
      generate_launcher_mode('r', [], [{ 'shell_command' => "open -a 'RemNote'" }]),
      generate_launcher_mode('m', [], [{ 'shell_command' => "open -a 'Messenger'" }]),
      generate_launcher_mode('j', [], [{ 'shell_command' => "open -a 'WhatsApp'" }]),
      generate_launcher_mode('y', [], [{ 'shell_command' => "open -a 'Grammarly'" }]),

    ].flatten,
  }

  puts JSON.pretty_generate(data)
end

def generate_launcher_mode(from_key_code, mandatory_modifiers, to)
  data = []

  ############################################################

  h = {
    'type' => 'basic',
    'from' => {
      'key_code' => from_key_code,
      'modifiers' => {
        'mandatory' => mandatory_modifiers,
        'optional' => [
          'any',
        ],
      },
    },
    'to' => to,
    'conditions' => [
      {
        'type' => 'variable_if',
        'name' => 'launcher_mode',
        'value' => 1,
      },
    ],
  }

  data << h

  ############################################################

  h = {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => parameters[:trigger_key],
        },
        {
          'key_code' => from_key_code,
        },
      ],
      'simultaneous_options' => {
        'key_down_order' => 'strict',
        'key_up_order' => 'strict_inverse',
        'to_after_key_up' => [
          {
            'set_variable' => {
              'name' => 'launcher_mode',
              'value' => 0,
            },
          },
        ],
      },
      'modifiers' => {
        'mandatory' => mandatory_modifiers,
        'optional' => [
          'any',
        ],
      },
    },
    'to' => [
      {
        'set_variable' => {
          'name' => 'launcher_mode',
          'value' => 1,
        },
      },
    ].concat(to),
    'parameters' => {
      'basic.simultaneous_threshold_milliseconds' => parameters[:simultaneous_threshold_milliseconds],
    },
  }

  data << h

  ############################################################

  data
end

main
