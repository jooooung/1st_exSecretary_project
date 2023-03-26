/**
 * 
 */
google.charts.load('current', {packages: ['corechart', 'line']});
google.charts.setOnLoadCallback(drawBasic);

function drawBasic() {

      var data = new google.visualization.DataTable();
      data.addColumn('number', 'X');
      data.addColumn('number', '몸무게');
      data.addColumn('number', '체지방량');
      data.addColumn('number', '골격근량');

      data.addRows([
        [1, 55, 20, 15],   [2, 53, 18, 16]
      ]);

      var options = {
				title: 'Inbody 기록',
        hAxis: {
          title: 'date'
        },
        vAxis: {
          title: 'Inbody'
        }
      };

      var chart = new google.visualization.LineChart(document.getElementById('chart_div'));

      chart.draw(data, options);
    }