// Copy and paste this code into the browser's dev console
// INTENDED FOR HUMBLE BUNDLES KEY PAGE IN YOUR ACCOUNT
// TO GENERATE A LIST OF UNUSED KEYS, PLEASE TICK THE BOX ON THE PAGE TO HIDE USED KEYS

const humbleKeyList = () => {
    let numOfGames = document.getElementsByClassName('game-name').length; // Get number of items on page
    let gamelist; // Initialize gamelist variable for later use
    for (let i = 1; i < numOfGames; i++){
        let gamename = document.getElementsByClassName('game-name')[i].firstElementChild.innerText; // Fetch game name
        gamelist += '\n' + gamename; // Add name at the end of the list
    };
    console.log(gamelist); // Show the generated list
};

humbleKeyList(); // Call function