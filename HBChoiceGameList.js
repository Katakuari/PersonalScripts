// Copy and paste this code into the browser's dev console
// INTENDED FOR HUMBLE BUNDLE's CHOICE PAGE FOR SUBSCRIBERS

var x = document.getElementsByClassName("content-choice-title").length; // Get number of games on page
for (let i=0; i<x; i++){
    let gamename = document.getElementsByClassName("content-choice-title")[i].innerText; // Fetch the name of the game
    var gamelist = gamelist+"\n"+gamename; // Add the name at the end of the list
};
gamelist // Show the generated list
