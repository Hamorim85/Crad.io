const q = document.getElementById("followings"),
    result = document.getElementById("currentValue2");

q.addEventListener("input", function() {
    result.innerHTML = q.value;
}, false);
