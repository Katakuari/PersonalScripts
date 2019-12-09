// Copy and paste this code into the browser's dev console
// INTENDED FOR HUMBLE BUNDLE's KEY PAGE IN YOUR ACCOUNT
// TO GENERATE A LIST OF UNUSED KEYS, PLEASE TICK THE BOX ON THE PAGE TO HIDE USED KEYS

var x = document.getElementsByClassName("game-name").length; // Get number of items on page
for (let i=1; i<x; i++){
    let gamename = document.getElementsByClassName("game-name")[i].firstElementChild.innerText; // Fetch game name
    var gamelist = gamelist+"\n"+gamename; // Add name at the end of the list
};
gamelist // Show the generated list
