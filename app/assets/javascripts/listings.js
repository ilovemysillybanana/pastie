
$(document).ready(function() {
  var pageListing = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: 'listings.json?l=%QUERY',
      wildcard: '%QUERY'
    }
  });

  $('#remote .typeahead').typeahead(null, {
    name: 'best-pictures',
    display: 'value',
    source: pageListing
  });
});
