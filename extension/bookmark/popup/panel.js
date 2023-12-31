console.log("panel.js")
document.addEventListener("click", (e) => {
    if (e.target.tagName !== "BUTTON" || !e.target.closest("#popup-content")) {
        // Ignore when click is not on a button within <div id="popup-content">.
        return;
      }

    console.log("panel.js")
    let the_key = browser.storage.sync.get("bookmark_server")
    console.log("panel.js2")
    function get_storage_success(result) {
        console.log("panel.js3")
        console.log(result.bookmark_server)
        var httpRequest = new XMLHttpRequest();
        url = result.bookmark_server || "http://my.site:2025";
        console.log("result_url: " + url);
        httpRequest.open('POST', url + "/submit_item", true);
        console.log("222")
        httpRequest.setRequestHeader("Content-type", "application/text");
        httpRequest.send("[" + document.getElementById("title").value + "](" + document.getElementById("url").value + ")");
        httpRequest.onreadystatechange = function () {
            if (httpRequest.readyState == 4 && httpRequest.status == 200) {
                var res = httpRequest.responseText;
                console.log(res)
                if (res == "success") {
                    console.log("extension: add success")
                }
            };
        };
    }
    the_key.then(get_storage_success, () => { console.log("url_value: ERROR") })
});


browser.tabs.query({ active: true, currentWindow: true })
    .then(tabs => {
        document.getElementById("title").value = tabs[0].title
        document.getElementById("url").value = tabs[0].url
    });




