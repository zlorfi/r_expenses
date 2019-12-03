import * as d3 from 'd3';
// import c3 from 'c3';
var c3 = require('c3');
// import '../src/c3.js';

d3.timeFormatDefaultLocale({
  'decimal': ',',
  'thousands': '.',
  'grouping': [3],
  'currency': ['', ' €'],
  'dateTime': '%a %b %e %X %Y',
  'date': '%d.%m.%Y',
  'time': '%H:%M:%S',
  'periods': ['AM', 'PM'],
  'days': ['Sonntag', 'Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag'],
  'shortDays': ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
  'months': ['Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'],
  'shortMonths': ['Jan', 'Feb', 'Mär', 'Apr', 'Mai', 'Jun', 'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Dez']
});

function generate_donut_chart(data_url) {
  document.addEventListener('turbolinks:load', function() {
    c3.generate({
      size: {
        height: 400
      },
      bindto: '#expense_given_month',
      data: {
        url: data_url,
        mimeType: 'json',
        type: 'donut',
      },
      tooltip: {
        format: {
          value: function(value, ratio, id) {
            return d3locale.numberFormat('$,.2f')(value);
          }
        }
      }
    });
  });
}