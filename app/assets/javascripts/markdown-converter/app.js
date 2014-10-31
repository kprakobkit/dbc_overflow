$(function() {
  $('.to-markdown').keyup(function(){
    var inputText = $(this).val();
    var parsedText = parseInputText(inputText);
    displayParsedText(parsedText);
  });

  function parseInputText(inputText) {
    var lines = inputText.split(/\n/);
    var parsedLines = []
    for (var i = 0; i < lines.length; i++) {
      parsedLines.push(convertToHtml(lines[i]))
    }
    return parsedLines.join(" ")
  }

  function convertToHtml(line) {
    if (line.match(/^#*/)) {
      var numOfH = line.match(/^#*/)[0].length
      var beginningHTag = "<h" + numOfH + ">"
      var endHTag = "</h" + numOfH + ">"
      var parsedLine = line.replace(line.match(/^#*/)[0],'')
      return (beginningHTag + parsedLine + endHTag)
    } else {
      return ("<p>" + line + "</p>");
    }
  }

  function displayParsedText(parsedText) {
    $('.preview-area').html(parsedText);
  };
});
