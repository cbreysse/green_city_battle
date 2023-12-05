import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="mini-map"
export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Object
  }
  connect() {
    console.log(this.markerValue);
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/kailaulau/clp9syl68003m01o01p266rin"
    })

    // wait a bit before jumping to user's location to avoid screen glitching
    this.#addMarkersToMap()
  }


  #addMarkersToMap() {
    const longitude = this.markerValue.lng
    const latitude = this.markerValue.lat
    new mapboxgl.Marker()
      .setLngLat([ longitude, latitude ])
      .addTo(this.map)


    const bounds = new mapboxgl.LngLatBounds()
    bounds.extend([ longitude, latitude ])
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 700 })
  }
}
