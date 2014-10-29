moment = require('moment-timezone')

module.exports = (robot) ->
  getMessage = (options) ->
    return options.name + '\'s time is ' + moment().tz(options.timezone).format(
      'YYYY-MM-DD HH:mm:ss'
    ) + ' and lives in ' + options.city

  robot.respond /(when) (.*)/i, (msg) ->
    name = msg.match[2]
    users =
      'eragonj':
        regex: /ej|eragonj|eragon|chen/i
        city: 'Taipei, Taiwan'
        tz: 'Asia/Taipei'
      '5punk':
        regex: /5punk|avanish|pathak/i
        city: 'Los Angeles(LA), USA'
        tz: 'America/Los_Angeles'
      'avi':
        regex: /avi|avihaymenahem|avihay|menahem/i
        city: 'Jerusalem, Israel'
        tz: 'Asia/Jerusalem'
      'jose':
        regex: /jose|jose32/i
        city: 'Los Angeles(LA), USA'
        tz: 'America/Los_Angeles'
      'agaelx':
        regex: /agaelx|uriel/i
        city: 'Chihuahua, Mexico'
        tz: 'America/Chihuahua'
      'blake':
        regex: /blake|bla|lafelur/i
        city: 'Fort Worth(TX), USA'
        tz: 'America/Matamoros'

    # let's print out all timezones
    if name is 'all'
      messages = []
      for userName, userInfo of users
        msg.send(getMessage({
          name: userName
          timezone: userInfo.tz
          city: userInfo.city
        }))
    # only one
    else
      matchedUser = null
      for userName, userInfo of users
        if userInfo.regex.exec name
          matchedUser = userInfo
          matchedUser.name = userName

      if matchedUser
        msg.send(getMessage({
          name: matchedUser.name
          timezone: matchedUser.tz
          city: matchedUser.city
        }))
      else
        msg.send('Can\'t find ' + name)
