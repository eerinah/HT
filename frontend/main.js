
/* Moralis init code */
const serverUrl = "https://ifry0n1b6gzi.usemoralis.com:2053/server";
const appId = "ET7KSpOgupHGNVEfzY00jUumM2J38zKdOYtsQsdw";
Moralis.start({ serverUrl, appId });
const TOKEN_CONTRACT_ADDRESS = "0x44e5d0038fad764777C3cAebbcf86D9084188342";

init = async () => {
    hideElement(userInfo);
    window.web3 = await Moralis.web3.enable();
    initUser();
}

initUser = async () => {
    if (await Moralis.User.current()) { // if user is logged in, show profile not connect
        hideElement(userConnectButton);
        showElement(userProfileButton);
        console.log("user is logged in");
    } else{
        showElement(userConnectButton);
        hideElement(userProfileButton);
        console.log("user not logged in");
    }
}

login = async () => {
    try {
        await Moralis.Web3.authenticate();
        initUser();
    } catch(error) {
        alert(error); // semicolon
    }
}

logout = async () => {
    await Moralis.User.logOut();
    hideElement(userInfo);
    initUser();
}

openUserInfo = async () => { // when clicking profile button
    user = await Moralis.User.current();
    if (user) {
        const email = user.get('email'); // gets the email
        if(email) {
            userEmailField.value = email;
        } else {
            userEmailField.value = "";
        }

        userUsernameField.value = user.get('username'); 

        const userAvatar = user.get('avatar');
        if(userAvatar) {
            userAvatarImage.src = userAvatar.url();
            showElement(userAvatarImg);
        } else{
            hideElement(userAvatarImg);
        }

        showElement(userInfo);
    } else{
        login();
    }
}


saveUserInfo = async () => {
    user.set('email', userEmail.value);
    user.set('username', userUsernameField.value);

    if (userAvatarFile.files.length > 0) { // only takes jpg
        const avatar = new Moralis.File("avatar.jpg", userAvatarFile.files[0]);
        user.set('avatar', avatar);
    }

    await user.save();
    alert("User info saved successfully!");
    openUserInfo();
}


hideElement = (element) => element.style.display = "none";
showElement = (element) => element.style.display = "block"; //shows element

const userConnectButton = document.getElementById("btnConnect");
userConnectionButton.onclick = login;

const userProfileButton = document.getElementById("btnUserInfo");
userProfileButton.onclick = openUserInfo;

const userInfo = document.getElementById("userInfo");
const userUsernameField = document.getElementById("txtUsername");
const userEmailField = document.getElementById("txtEmail");
const userAvatarImage = document.getElementById("imgAvatar");
const userAvatarFile = document.getElementById("fileAvatar");

document.getElementById("btnCloseUserInfo").onclick = () => hideElement(userInfo);
document.getElementById("btnLogout").onClick = logout;
document.getElementById("btnSaveUserInfo").onClick = SaveUserInfo;
init();