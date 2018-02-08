function fnTrapKD(btn, event) {
    if (document.all) {
        if (event.keyCode == 13) {
            event.returnValue = false;
            event.cancel = true;
            btn.click();
        }
    } else if (document.getElementById) {
        if (event.which == 13) {
            event.returnValue = false;
            event.cancel = true;
            btn.click();
        }
    } else if (document.layers) {
        if (event.which == 13) {
            event.returnValue = false;
            event.cancel = true;
            btn.click();
        }
    }
}