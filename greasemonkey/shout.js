function tryPatching() {
  return function () {
    let chans = document.getElementById('sidebar').querySelectorAll('.chan.channel');
    console.log(chans.length);
    if (chans.length === 0) {
      console.log(chans.length);
      console.log('Chans not found, retrying...');
      window.setTimeout(tryPatching(mouse), 1000);
      return;
    }
    document.addEventListener('keydown', function (ev) {
      if (ev.ctrlKey) {
        let kc = ev.keyCode - 49;
        if (0 <= kc && kc <= 8) {
          let chans = document.getElementById('sidebar').querySelectorAll('.chan.channel');
          chans[kc].click();
        }
      }
    });
  }
}

window.setTimeout(tryPatching(), 1000);
