angular.module('markDownApp', ['ngSanitize']).controller('markDownController', ['$scope', function($scope) {
  $scope.inputText;

  $scope.parseInputText = function() {
    var lines = $scope.inputText.split(/\n/);
    var parsedLines = [];
    for (var i = 0; i < lines.length; i++) {
      parsedLines.push($scope.convertToHtml(lines[i]))
    }
    return parsedLines.join(" ")
  };

  $scope.convertToHtml = function(line) {
    var result_string;
    if ((/^#+/).test(line)) {
      var numOfH = line.match(/^#+/)[0].length;
      var beginningTag = "<h" + numOfH + ">";
      var endTag = "</h" + numOfH + ">";
      var parsedLine = line.replace(/\#/g,'');
      result_string = (beginningTag + parsedLine + endTag);
    } else if ((/^\*.*\*$/).test(line)) {
      var beginningTag = "<strong>";
      var endTag = "</strong>";
      var parsedLine = line.replace(/\*/g,'');
      result_string = (beginningTag + parsedLine + endTag);
    } else if ((/^_.*_$/).test(line)) {
      var beginningTag = "<em>";
      var endTag = "</em>";
      var parsedLine = line.replace(/\_/g,'');
      result_string = (beginningTag + parsedLine + endTag);
    } else {
      result_string = ("<p>" + line + "</p>");
    }
    return result_string
  }
}]);



