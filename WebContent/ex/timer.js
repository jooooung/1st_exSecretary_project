/**
 * 
 */
let timer_hour;
    let timer_min;
		let timer_sec;
		let timer = 0;
		function startClock() {
			var sec = parseInt(document.getElementById("sec").innerText);
      var min = parseInt(document.getElementById("min").innerText);
      var hour = parseInt(document.getElementById("hour").innerText);
    //start seconds
      timer_sec = setInterval(function(){
          sec++;
          if(sec == 60) {
              sec = "00";
          } else if(sec < 10){
              sec = "0" + sec;
          }
          document.getElementById("sec").innerText = sec;
					$('input[name=esec]').attr('value', sec);
      }, 1000);

      //start minutes
      timer_min = setInterval(function(){
          min++;

          if(min == 60) {
              min = 0;
          } else if(min < 10){
              min = "0" + min;
          }

          document.getElementById("min").innerText = min;
					$('input[name=emin]').attr('value', min);
      }, 60000);

      //start hours
      timer_hour = setInterval(function(){
          //console.log(hour);
          hour++;
          if(hour < 10){
              hour = "0" + hour;
          }
          document.getElementById("hour").innerText = hour;
          $('input[name=ehour]').attr('value', hour);
      }, 3600000);

      timer++;
		}
		function stopClock() {
      clearInterval(timer_sec);
      clearInterval(timer_min);
      clearInterval(timer_hour);

      timer--;
      if(timer < 0)
          timer = 0;
		}
		function resetClock() {
			stopClock();
			document.getElementById("sec").innerText = "00";
      document.getElementById("min").innerText = "00";
      document.getElementById("hour").innerText = "00";
		}