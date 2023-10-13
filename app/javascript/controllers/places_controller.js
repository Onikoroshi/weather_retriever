import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "field", "latitude", "longitude", "postal_code", "country_code" ]

  connect() {
    if (typeof(google) != "undefined") {
      this.initMap()
    }
  }

  initMap() {
    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
    this.autocomplete.addListener("place_changed", this.placeChanged.bind(this))
  }

  placeChanged() {
    let place = this.autocomplete.getPlace()

    if (!place.geometry) {
      window.alert("No details available for input: ${place.name}")
      return
    }

    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()

    for (let component of place.address_components) {
      switch(component.types[0]) {
        case "postal_code":
          this.postal_codeTarget.value = component.long_name
          break;
        case "country":
          this.country_codeTarget.value = component.short_name
          break;
      }
    }
  }

  keydown(event) {
    if (event.key == "Enter") {
      event.preventDefault()
    }
  }
}
