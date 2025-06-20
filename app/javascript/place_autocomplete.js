window.initAutocomplete = function() {
  const inputSpot = document.getElementById("spot");
  const inputAddress = document.getElementById("address");

  if (!inputSpot || !inputAddress) return;

  const options = {
    types: ["establishment"],
    componentRestrictions: { country: "JP" },
  };

  const autocompleteSpot = new google.maps.places.Autocomplete(inputSpot, options);
  const autocompleteAddress = new google.maps.places.Autocomplete(inputAddress, options);

  autocompleteSpot.addListener("place_changed", function() {
    const place = autocompleteSpot.getPlace();
    inputSpot.value = place.name;
    inputAddress.value = place.formatted_address;
  });

  autocompleteAddress.addListener("place_changed", function() {
    const place = autocompleteAddress.getPlace();
    inputSpot.value = place.name;
    inputAddress.value = place.formatted_address;
  });
};
