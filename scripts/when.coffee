moment = require('moment-timezone')

module.exports = (robot) ->
  robot.respond /(when) (.*)/i, (msg) ->
    name = msg.match[2]
    users =
      'eragonj':
        regex: /ej|eragonj|eragon|chen/i
        tz: 'Asia/Taipei'
      '5punk':
        regex: /5punk|avanish|pathak/i
        tz: 'America/Los_Angeles'
      'avi':
        regex: /avi|avihaymenahem|avihay|menahem/i
        tz: 'Asia/Jerusalem'
      'jose':
        regex: /jose|jose32/i
        tz: 'America/Los_Angeles'
      'agaelx':
        regex: /agaelx|uriel/i
        tz: 'America/Chihuahua'

    matchedUser = null
    for userName, userInfo of users
      if userInfo.regex.exec name
        matchedUser = userInfo
        matchedUser.name = userName

    if matchedUser
      msg.send(
        matchedUser.name + '\'s time is ' + moment().tz(matchedUser.tz).format(
          'YYYY-MM-DD HH:mm:ss'
        )
      )
    else
      msg.send 'Can\'t find ' + name
