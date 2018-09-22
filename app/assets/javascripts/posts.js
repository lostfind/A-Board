function passShow (id) {
    var element = document.getElementsByClassName('confirm');
    for (var i = 0; i < element.length; i++) {
        element[i].classList.add('hidden');
    }

    var element = document.getElementById(id);
    element.classList.remove('hidden');
    element.children[0][2].focus();
}

function passHidden (id) {
    var element = document.getElementById(id);
    element.classList.add('hidden');
}