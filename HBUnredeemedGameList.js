// Copy and paste this code into your browsers dev console
// INTENDED FOR HUMBLE BUNDLES KEY PAGE IN YOUR ACCOUNT
// ONLY TESTED IN FIREFOX


const humbleUnredeemedGameList = () => {
    let numOfGames = document.getElementsByClassName('game-name').length; // Get number of games on page
    let gamelist; // Initialize gamelist var for later use
    let gamename; // Initialize gamename var for later use
    for (let i = 1; i < numOfGames; i++){
        gamename = document.getElementsByClassName('game-name')[i].firstElementChild.innerText; // Fetch current game name
        gamelist += '\n' + gamename; // Add current game at the end of the list
    };
    console.log(gamelist); // Log the generated list in the console
};

if (document.getElementById('hide-redeemed').checked === false){ // Check if checkbox has already been clicked
    document.getElementById('hide-redeemed').click(); // Click checkbox to hide redeemed keys
};

setTimeout(humbleUnredeemedGameList, 2000); // Call function with a 2 second delay
