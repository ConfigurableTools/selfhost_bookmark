function saveOptions(e) {
    e.preventDefault();
    browser.storage.sync.set({
      bookmark_server: document.querySelector("#bookmark_server").value,
    });
    console.log("--->options.js: saveOptions<---")
  }
  
  function restoreOptions() {
    console.log("--->options.js: Begining<--- "+document.querySelector("#bookmark_server").value)
    console.log("--->options.js: restoreOptions<---")
    bookmark_server = "http://my.site:2025"
    function setCurrentChoice(result) {
      document.querySelector("#bookmark_server").value = result.bookmark_server || "http://my.site:2025";
      console.log("--->options.js: success<--- "+document.querySelector("#bookmark_server").value)
      // Update Value
      browser.storage.sync.set({
        bookmark_server: document.querySelector("#bookmark_server").value,
      });
      //check value
      browser.storage.sync.get("bookmark_server").then(()=>{console.log("--->option.js: "+result.bookmark_server)}, onError)
    }
  
    function onError(error) {
      console.log("--->options.js: fail<---")
      console.log(`Error: ${error}`);
    }
  
    let getting = browser.storage.sync.get("bookmark_server");
    getting.then(setCurrentChoice, onError);
  }
  
  console.log("--->options.js: DOMContentLoaded<---")
  document.addEventListener("DOMContentLoaded", restoreOptions);
  console.log("--->options.js: form addEventListener<---")
  document.querySelector("form").addEventListener("submit", saveOptions);
  

