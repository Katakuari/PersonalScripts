// Copy and paste this code into the browsers dev console
// INTENDED FOR HUMBLE BUNDLES CHOICE PAGE FOR SUBSCRIBERS


const humbleChoiceGames = () => {
    let numOfGames = document.getElementsByClassName('content-choice-title').length; // Get number of games on page
    let gamelist; // Initialize gamelist variable for later use
    for (let i = 0; i < numOfGames; i++){
        let gamename = document.getElementsByClassName('content-choice-title')[i].innerText; // Fetch the name of the game
        gamelist += '\n' + gamename; // Add name at the end of the list
    };
    console.log(gamelist); // Show the generated list
};

humbleChoiceGames(); // Call function