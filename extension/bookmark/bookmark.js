
console.log("bookmark.js")


function onError(error) {
 console.log(`Error: ${error}`);
}

function onGot(item) {
 let bookmark_server = "http://my.site:2025/submit_item";
 if (item.bookmark_server) {
   bookmark_server = item.bookmark_server;
 }

}

const getting = browser.storage.sync.get("bookmark_server");
getting.then(onGot, onError);