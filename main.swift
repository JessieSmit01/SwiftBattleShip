import Foundation

//enumeration for ship type
public enum ShipType
{
  case tugBoat, submarine, airCraftCarrier
}

//Class for ships
public class Ship
{
  public let type : ShipType //stores ship type
  public var shipPosition = [[Int]] () //stores position of each character
  public var size : Int{ //the nuber of chars representing the ship
    switch type
    {
      case ShipType.tugBoat:
        return 2
      case ShipType.submarine:
        return 3
      //the only other ship type left to match is air craft carrier
      default:
        return 4
    }
  }

  //character representing the ships based on ship type.
  public var symbol : String {
    switch type
    {
      case ShipType.tugBoat:
        return "Ӝ"
      case ShipType.submarine:
        return "Ө"
      //the only other ship type left to match is air craft carrier
      default:
        return "Ш"
    }
  }
  //used to determine if the ship is sunk
  public var health: Int = 0

  //initialize the class by passing in a ship type.
  public init(type: ShipType)
  {
    //set the ship type
    self.type = type
    //set the health based on ship type
    switch type
    {
      case ShipType.tugBoat:
        self.health = 2
        return
      case ShipType.submarine:
        self.health = 3
        return
      //the only other ship type left to match is air craft carrier
      default:
        self.health = 4
        return
    }
  }

  //this function will take in a starting row and column and a direction.
  //passing in 0 for direction will result in a horizontal ship
  //passing in anything other than 0 will result in a vertical ship.
  public func setShipPositions(starting_x:Int, starting_y:Int, direction:Int)
  {
    //horizontal
    if direction == 0
    {
      //for the length of the ship, create cooridinate positions for each length
      for i in 0..<self.size
      {
        self.shipPosition.append([Int]())
        self.shipPosition[i] = [starting_x, starting_y + i]
      }
    }
    else
    {
      //for the length of the ship, create cooridinate positions for each length
      for i in 0..<self.size
      {
        self.shipPosition.append([Int]())
        self.shipPosition[i] = [starting_x + i, starting_y ]
      }
    }

  }
}



//This class will represent the board. It will keep track of all ships on the board.
public class GameBoard
{
  public var ships : [Ship] = [Ship] () //the ships of the board

  public var board = [[String]] () //the boards current state

  public var shipsSunk: Int = 0 //the ammount of ships sunk

  public var shipPositions = [[String]] () //stores the positions of the ships.
  
  //each index position matches the same ship position in the ships array
  

  public init()
  {
    //initialize the board to new game
    for i in 0...10
    {
      //create a board with * in each position.
      //set the ships positions and keep track of them in the shipPositions array
      self.board.append([String]())
      self.shipPositions.append([String]())
      for _ in 0...11
      {
        self.board[i].append("*")
        self.shipPositions[i].append("*")
      }
      
      
    }
      //draw the rows as letters on the board
      board[0][0] = "A";
      board[1][0] = "B";
      board[2][0] = "C";
      board[3][0] = "D";
      board[4][0] = "E";
      board[5][0] = "F";
      board[6][0] = "G";
      board[7][0] = "H";
      board[8][0] = "I";
      board[9][0] = "J";
    
    //add ships to the board
    addShips()
    //play the game
    playGame()
  }


  //this function will be called to add ships to the game board
  public func addShips()
  {
    //hard code the 5 ships
    let ship1 : Ship = Ship(type: ShipType.tugBoat)
    let ship2 : Ship = Ship(type: ShipType.submarine)
    let ship3 : Ship = Ship(type: ShipType.airCraftCarrier)
    let ship4 : Ship = Ship(type: ShipType.tugBoat)
    let ship5 : Ship = Ship(type: ShipType.submarine)

    //add the ships to the board
    self.ships.append(ship1)
    self.ships.append(ship2)
    self.ships.append(ship3)
    self.ships.append(ship4)
    self.ships.append(ship5)

    //set the ships positions
    ship1.setShipPositions(starting_x: 0, starting_y: 0, direction:0)
    ship2.setShipPositions(starting_x: 2, starting_y: 3, direction:1)
    ship3.setShipPositions(starting_x: 4, starting_y: 5, direction:0)
    ship4.setShipPositions(starting_x: 6, starting_y: 4, direction:1)
    ship5.setShipPositions(starting_x: 8, starting_y: 6, direction:0)
    
    //for each ship, add the ships coordinates to the shipPositions attribute and set it as the ships symbol.
    for ship in self.ships{
      for coor in ship.shipPosition
      {
        self.shipPositions[coor[0]][coor[1]] = ship.symbol
      }
    }
  }


  //this function will be used to display the board to the player
  public func displayBoard() -> String
  {
    //set the column identifiers of the board
    var display : String = "   1 2 3 4 5 6 7 8 9 10\n"
    //go through each space on the board and print it out
    for i in 0..<10
    {
      for j in 0..<11
      {
        display = "\(display) \(self.board[i][j])"
      }
      display = "\(display)\n"
    }

    //return the string representing the board
    return display
  }

  //this function was used for debugging to see if the ships were placed properly
  public func displayShipPositions() -> String
  {
     
     var display : String = ""
      //go through each space, and print out inscluding the ship positions uncovered.
      for i in 0..<10
      {
        for j in 0..<11
        {
          display = "\(display) \(self.shipPositions[i][j])"
        }
        display = "\(display)\n"
      }

      return display
  }

  //this function will take in a letter representing a row and return and intenger that can be used to index into that row.
  private func letterToRow(letter: String) -> Int
  {
    //each case represents a valid letter, returning its matching integer row number
    switch letter
    {
      case "A":
        return 0
      case "a":
        return 0
      case "B":
        return 1
      case "b":
        return 1
      case "C":
        return 2
      case "c":
        return 2
      case "D":
        return 3
      case "d":
        return 3
      case "E":
        return 4
      case "e":
        return 4
      case "F":
        return 5
      case "f":
        return 5
      case "G":
        return 6
      case "g":
        return 6
      case "H":
        return 7
      case "h":
        return 7
      case "I":
        return 8
      case "i":
        return 8
      case "J":
        return 9
      case "j":
        return 9
      default:
        return -1 
    }
  }

  //this function will check if the player has won the game
  public func hasPlayerWon() -> Bool
  {
    //go through each ship and check if its coordinates have been uncovered on the board
    for ship in self.ships
      {
        for coor in ship.shipPosition
        {
          if (self.board[coor[0]][coor[1] + 1] == ship.symbol) == false
          {
            //if one corrdinate has not been uncovrered return false and the game is not over yet
            return false
          }
        }
        
      }
      //game has been completed.
      return true
  }

  //this function will be called to play the game for the user
  public func playGame()
  {
    //print welcome text
    print("Welcome To Command Line Battleship\n")
    //display the board
    print("\(self.displayBoard())")
    //current game complete condition is false
    var done : Bool = false
    //while the game is not compelte, ask the player for a row and column
    //display what is under the coordiantes chosen by the player.
    while done == false
    {
      print("Please enter a row\n") //ask user for a row
      var rowVal : String = readLine()!
      var row : Int? = Int(self.letterToRow(letter: rowVal))
      while row! == -1 || row! > 10 //error check the row is valid
      {
        print("Please enter a valid row") 
        rowVal = readLine()!
        row = Int(self.letterToRow(letter: rowVal))
      }
      print("Please enter a column\n") //prompt user for a column
      var col : Int? = Int(readLine()!)
      while col == nil || col! > 10 //error check for valid column
      {
        print("Please enter a valid column\n")
        col = Int(readLine()!)
      }
      //for each ship on the board check if its coordinates match that of the users. if it does, uncover the ship symbol
      for ship in self.ships
      {
        for coor in ship.shipPosition
        {
          //coordinate matches
          if coor[0] == row! && coor[1] == col! - 1
          {
            self.board[row!][col!] = ship.symbol
            ship.health = ship.health - 1 //lower the ship health by one
            isShipSunk(ship: ship)
            break
          }
          //coordinate does not match
          self.board[row!][col! ] = " "
        }
        //if the coordinate has been uncovered, break
        if self.board[row!][col!] == ship.symbol
        {
          break
        }
      }
      //print out the board again
      print("\(self.displayBoard())") 
      //check if the player has won
      done = hasPlayerWon()
    }
    //when game is done, print out a congratulations text
    print("Congratulations! You got all the ships!")
  }
  //this function will be used to check if a ship has been sunk
  private func isShipSunk(ship: Ship)
  {
    //get the ship type in string form
    var t : String {
      switch ship.type
      {
        case ShipType.tugBoat:
          return "Tugboat"
        case ShipType.submarine:
          return "Submarine"
        //the only other ship type left to match is air craft carrier
        default:
          return "Aircraft Carrier"
          
      }
    }
    //if the ships health is 0, print out a message to the user
    if ship.health == 0
    {
      print("You sunk a \(t)!")
    }
  }
}
//quit will be used to determine if the user wants to play again afetr the game has ended
var quit : Bool = false
//while the user wants to keep playing
while quit == false{
  //instantiate a gameboard
  let _ : GameBoard = GameBoard()
  //after the gameboards init plays the first game, check if the player wants to play again
  print("Would You like to play again? Enter 'Yes' or 'No'")
  var response : String? = readLine()!
  //error check for a valid response form the user
  while !(response == "Yes" || response == "yes" || response == "No" || response == "no")  
  {
    //ask the user if they want to play again
    print("Would You like to play again? Enter 'Yes' or 'No'")
    response = readLine()!
  }
  //if yes play again
  if response! == "Yes" || response! == "yes"
  {
    quit = false
  }
  else //no, quit the game
  {
    //print a goodbye message to the user.
    print("Thank you for playing Command Line Battleship!")
    quit = true
  }

}


