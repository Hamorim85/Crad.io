var p = document.getElementById("followers"),
    res = document.getElementById("currentValue");

p.addEventListener("input", function() {
    res.innerHTML = p.value;
}, false);

