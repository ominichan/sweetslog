document.addEventListener('DOMContentLoaded', function () {
  const inputSpot = document.getElementById('Spot');
  const inputAddress = document.getElementById('Address');

  // オートコンプリートのオプション
  const options = {
    types: ['establishment'],
    componentRestrictions: { country: 'JP' },
  };

  // オートコンプリート適用
  const autocompleteSpot = new google.maps.places.Autocomplete(inputSpot, options);
  const autocompleteAddress = new google.maps.places.Autocomplete(inputAddress, options);

  // タイトルのオートコンプリートが選択されたとき
  autocompleteSpot.addListener('place_changed', function() {
    const place = autocompleteSpot.getPlace();
    inputSpot.value = place.name;
    inputAddress.value = place.formatted_address;
  });

  // 住所のオートコンプリートが選択されたとき
  autocompleteAddress.addListener('place_changed', function() {
    const place = autocompleteAddress.getPlace();
    inputSpot.value = place.name;
    inputAddress.value = place.formatted_address;
  });
});