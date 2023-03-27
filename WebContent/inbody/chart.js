/**
 * 
 */
google.charts.load('current', {packages: ['corechart', 'line']});
google.charts.setOnLoadCallback(drawChart);


function drawChart() {
	
      var data = new google.visualization.DataTable();
      data.addColumn('date', '날짜');
      data.addColumn('number', '몸무게');
      data.addColumn('number', '체지방량');
      data.addColumn('number', '골격근량');

      data.addRows([
        [new Date(23, 3, 22), 50, 15, 15],   [new Date(23, 3, 23), 51, 16, 16],
        [new Date(23, 3, 24), 52, 17, 15],   [new Date(23, 3, 25), 53, 18, 16],
        [new Date(23, 3, 26), 54, 18, 15],   [new Date(23, 3, 27), 100, 19.5, 16],
      ]);

      var options = {
				title: 'Inbody 기록',
				width: '75%',
				height: 300,
        hAxis: {
          title: 'date',
					format: 'yy-MM-dd'
        },
        vAxis: {
          title: 'Inbody'
        }
      };

      var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
      chart.draw(data, options);
			window.addEventListener('resize', drawChart, false);
    }