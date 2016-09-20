/* Number of teams */
let teamNum = 3

/* Array to store all the soccer players before assigned into teams. */
var players: [[String: Any]] = []

/* Teams names */
var teamNames: [String] = []

/* Teams practice time */
var teamSchedules: [String] = []

/* Assigned teams */
var teamAssignedPlayers: [[[String: Any]]] = []

/* Experienced players */
var experiencedPlayers: [[String: Any]] = []

/* Inexperienced players */
var inexperiencedPlayers: [[String: Any]] = []



/**
 * Initialize the soccor teams info.
 */
func initTeams() {
  // Manully create soccer players information.
  players.append(soccerPlayer("Joe Smith", 42, true, "Jim and Jan Smith"))
  players.append(soccerPlayer("Jill Tanner", 36, true, "Clara Tanner"))
  players.append(soccerPlayer("Bill Bon", 43, true, "Sara and Jenny Bon"))
  players.append(soccerPlayer("Eva Gordon", 45, false, "Wendy and Mike Gordon"))
  players.append(soccerPlayer("Matt Gill", 40, false, "Charles and Sylvia Gill"))
  players.append(soccerPlayer("Kimmy Stein", 41, false, "Bill and Hillary Stein"))
  players.append(soccerPlayer("Sammy Adams", 45, false, "Jeff Adams"))
  players.append(soccerPlayer("Karl Saygan", 42, true, "Heather Bledsoe"))
  players.append(soccerPlayer("Suzane Greenberg", 44, true, "Henrietta Dumas"))
  players.append(soccerPlayer("Sal Dali", 41, false, "Gala Dali"))
  players.append(soccerPlayer("Joe Kavalier", 39, false, "Sam and Elaine Kavalier"))
  players.append(soccerPlayer("Ben Finkelstein", 44, false, "Aaron and Jill Finkelstein"))
  players.append(soccerPlayer("Diego Soto", 41, true, "Robin and Sarika Soto"))
  players.append(soccerPlayer("Chloe Alaska", 47, false, "David and Jamie Alaska"))
  players.append(soccerPlayer("Arnold Willis", 43, false, "Claire Willis"))
  players.append(soccerPlayer("Phililip Helm", 44, true, "Thomas Helm and Eva Jones"))
  players.append(soccerPlayer("Les Clay", 42, true, "Wynonna Brown"))
  players.append(soccerPlayer("Herschel Krustofski", 45, true, "Hyman and Rachel Krustofski"))
  
  for _ in 0..<teamNum {
    teamAssignedPlayers.append([])
  }
  
  teamNames.append("Dragons")
  teamNames.append("Sharks")
  teamNames.append("Raptors")
  
  teamSchedules.append("March 17, 1pm")
  teamSchedules.append("March 17, 3pm")
  teamSchedules.append("March 18, 1pm")
}


/**
 * Create a dictionary containing info for soccer player.
 */
func soccerPlayer(_ name: String, _ height: Int, _ experience: Bool,
    _ guardianName: String) -> [String: Any] {
  var soccerPlayer: [String: Any] = [:]
  soccerPlayer["name"] = name
  soccerPlayer["height"] = height
  soccerPlayer["hasExperience"] = experience
  soccerPlayer["guardianName"] = guardianName
  return soccerPlayer
}


/**
 * Divide players into two groups by experience.
 */
func dividePlayersByExperience() {
  for player in players {
    if let hasExperience = player["hasExperience"] {
      if hasExperience as! Bool {   // Forced down cast since we are sure it is Bool.
        experiencedPlayers.append(player)
      } else {
        inexperiencedPlayers.append(player)
      }
    }
  }
}


/**
 * Sort the players according to their height using bubble sort.
 */
func sortPlayersByHeight(_ players: inout [[String: Any]]) {
  for _ in 0..<players.count {
    for i in 0..<players.count - 1 {
      if (getHeight(players[i]) > getHeight(players[i + 1])) {
        let tmp = players[i];
        players[i] = players[i + 1]
        players[i + 1] = tmp
      }
    }
  }
}


/**
 * Returns the height of a player.
 */
func getHeight(_ player: [String: Any]) -> Int {
  var ret = 0
  if let height = player["height"] {
    ret = height as! Int
  }
  return ret
}


/**
 * Assign players to the three teams: Dragons, Sharks and Raptors.
 * Used to assign both experienced and inexperienced players.
 */
func assignPlayers(_ players: [[String: Any]]) {
  /**
   * Since the each team has same number of players and experienced players,
   * N must be divisible by teamNum.
   */
  let N = players.count
  let playerPerTeam = N / teamNum
  
  /**
   * The first round of assigning tries our best to put highest player and shortest
   * player together in one team.
   */
  for k in 0..<teamNum {
    for j in 0..<playerPerTeam / 2 {
      teamAssignedPlayers[k].append(players[playerPerTeam / 2 * k + j])
      teamAssignedPlayers[k].append(players[N - 1 - playerPerTeam / 2 * k - j])
    }
  }
  
  /**
   * If playerPerTeam is odd number, that means there are teamNum players left from
   * the first round assigning. Then we can just assign them evenly to teamNum teams.
   */
  if playerPerTeam % 2 == 1 {
    for k in 0..<teamNum {
      teamAssignedPlayers[k].append(players[k + playerPerTeam / 2 * teamNum])
    }
  }
}


/**
 * Calculate and print the average height of each team.
 */
func calAverageHeight() {
  var k = 0
  for team in teamAssignedPlayers {
    var sum = 0
    for player in team {
      sum += getHeight(player)
    }
    print("Team \(k) average height: \(Double(sum) / Double(team.count))")
    print("**********************************************************************")
    for player in team {
      print("\(player["name"]!), \(player["hasExperience"]! as! Bool ? "experienced" : "inexperienced"), \(player["height"]!)")
    }
    print()
    print()
    k += 1
  }
}


/**
 * Print personalized letters at console.
 */
func printPersonalizedLetters() {
  for i in 0..<teamNum {
    print("Letters for players in \(teamNames[i]) team:")
    print("*********************************************************************")
    print()
    for player in teamAssignedPlayers[i] {
      print("Hi, \(player["guardianName"]!), your child \(player["name"]!) is in \(teamNames[i]) team, please attend the practice at \(teamSchedules[i]) if you like.")
    }
    print()
    print()
  }
}


initTeams()

dividePlayersByExperience()

sortPlayersByHeight(&experiencedPlayers)
sortPlayersByHeight(&inexperiencedPlayers)

assignPlayers(experiencedPlayers)
assignPlayers(inexperiencedPlayers)

calAverageHeight()
printPersonalizedLetters()


/**
 * The result in console:
 *
 *
 Team 0 average height: 41.6666666666667
 **********************************************************************
 Jill Tanner, experienced, 36
 Herschel Krustofski, experienced, 45
 Karl Saygan, experienced, 42
 Joe Kavalier, inexperienced, 39
 Chloe Alaska, inexperienced, 47
 Sal Dali, inexperienced, 41
 
 
 Team 1 average height: 42.5
 **********************************************************************
 Diego Soto, experienced, 41
 Phililip Helm, experienced, 44
 Les Clay, experienced, 42
 Matt Gill, inexperienced, 40
 Sammy Adams, inexperienced, 45
 Arnold Willis, inexperienced, 43
 
 
 Team 2 average height: 43.1666666666667
 **********************************************************************
 Joe Smith, experienced, 42
 Suzane Greenberg, experienced, 44
 Bill Bon, experienced, 43
 Kimmy Stein, inexperienced, 41
 Eva Gordon, inexperienced, 45
 Ben Finkelstein, inexperienced, 44
 
 
 Letters for players in Dragons team:
 *********************************************************************
 
 Hi, Clara Tanner, your child Jill Tanner is in Dragons team, please attend the practice at March 17, 1pm if you like.
 Hi, Hyman and Rachel Krustofski, your child Herschel Krustofski is in Dragons team, please attend the practice at March 17, 1pm if you like.
 Hi, Heather Bledsoe, your child Karl Saygan is in Dragons team, please attend the practice at March 17, 1pm if you like.
 Hi, Sam and Elaine Kavalier, your child Joe Kavalier is in Dragons team, please attend the practice at March 17, 1pm if you like.
 Hi, David and Jamie Alaska, your child Chloe Alaska is in Dragons team, please attend the practice at March 17, 1pm if you like.
 Hi, Gala Dali, your child Sal Dali is in Dragons team, please attend the practice at March 17, 1pm if you like.
 
 
 Letters for players in Sharks team:
 *********************************************************************
 
 Hi, Robin and Sarika Soto, your child Diego Soto is in Sharks team, please attend the practice at March 17, 3pm if you like.
 Hi, Thomas Helm and Eva Jones, your child Phililip Helm is in Sharks team, please attend the practice at March 17, 3pm if you like.
 Hi, Wynonna Brown, your child Les Clay is in Sharks team, please attend the practice at March 17, 3pm if you like.
 Hi, Charles and Sylvia Gill, your child Matt Gill is in Sharks team, please attend the practice at March 17, 3pm if you like.
 Hi, Jeff Adams, your child Sammy Adams is in Sharks team, please attend the practice at March 17, 3pm if you like.
 Hi, Claire Willis, your child Arnold Willis is in Sharks team, please attend the practice at March 17, 3pm if you like.
 
 
 Letters for players in Raptors team:
 *********************************************************************
 
 Hi, Jim and Jan Smith, your child Joe Smith is in Raptors team, please attend the practice at March 18, 1pm if you like.
 Hi, Henrietta Dumas, your child Suzane Greenberg is in Raptors team, please attend the practice at March 18, 1pm if you like.
 Hi, Sara and Jenny Bon, your child Bill Bon is in Raptors team, please attend the practice at March 18, 1pm if you like.
 Hi, Bill and Hillary Stein, your child Kimmy Stein is in Raptors team, please attend the practice at March 18, 1pm if you like.
 Hi, Wendy and Mike Gordon, your child Eva Gordon is in Raptors team, please attend the practice at March 18, 1pm if you like.
 Hi, Aaron and Jill Finkelstein, your child Ben Finkelstein is in Raptors team, please attend the practice at March 18, 1pm if you like.
*/

