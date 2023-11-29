import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    userMarker: String
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/kailaulau/clp9syl68003m01o01p266rin"
    })

    // wait a bit before jumping to user's location to avoid screen glitching
    setTimeout(this.#geolocateUser, 300)
    this.#addMarkersToMap()
  }

  showSpotDetails(event) {
    // TODO: show the spot details
  }

  #geolocateUser = () => {
    if (!navigator.geolocation) {
      console.log("Geolocation is not supported in this browser.")
      // TODO: show an alert to the user
    } else {
      const geolocOptions = {
        enableHighAccuracy: true,
        timeout: 5000,
        maximumAge: 0
      }
      navigator.geolocation.getCurrentPosition(this.#centerMapOnUser, this.#handleGeolocError, geolocOptions)
    }
  }

  #centerMapOnUser = (data) => {
    const userMarker = document.createElement('div')
    userMarker.innerHTML = this.userMarkerValue
    new mapboxgl.Marker(userMarker)
          .setLngLat([data.coords.longitude, data.coords.latitude])
          .addTo(this.map)
        const bounds = new mapboxgl.LngLatBounds()
        bounds.extend([ data.coords.longitude, data.coords.latitude ])
        this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 1500 })
  }

  #handleGeolocError = (error) => {
    console.log(error)
    // TODO: show an alert to the user
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const newMarker = new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)

      newMarker.getElement().setAttribute('data-action', 'click->map#showSpotDetails')
    })
  }
}
