import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/kailaulau/clp9syl68003m01o01p266rin"
    })

    this.#geolocateUser()
    // add user marker to map
  }

  #geolocateUser = () => {
    console.log("Checking geolocation availability...")
    if (!navigator.geolocation) {
      console.log("Geolocation is not supported in this browser.")
    } else {
      console.log("Geolocation is supported!")
      console.log("Geolocating user...")
      navigator.geolocation.getCurrentPosition(this.#success.bind(this), this.#error.bind(this))
    }
  }

  #success = (position) => {
    console.log("Geolocation successful!")
    console.log(`Latitude: ${position.coords.latitude}, Longitude: ${position.coords.longitude}`)
    this.#addUserMarkerToMap(position.coords)
  }

  #error = () => {
    console.log("Unable to get your location.")
  }

  #addUserMarkerToMap = (coords) => {
    const userMarker = new mapboxgl.Marker()
      .setLngLat([ coords.longitude, coords.latitude ])
      .addTo(this.map)
    this.markersValue.push(userMarker)
    // TODO: get the map to center on user marker
    this.#fitMapToMarkers()
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 15 })
  }
}
