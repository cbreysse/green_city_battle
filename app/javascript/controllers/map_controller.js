import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    userMarker: String
  }

  static targets = ["map", "spotDetails", "spotDetailsContent"]

  connect() {
    // load geoJSON data
    this.#loadData()

    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/kailaulau/clp9syl68003m01o01p266rin"
    })

    // wait a bit before jumping to user's location to avoid screen glitching
    setTimeout(this.#geolocateUser, 300)
    this.#addMarkersToMap()
  }

  async #loadData() {
    try {
      const response = await fetch("/arrondissements.json")
      const data = await response.json()
      this.map.on('load', () => {
        data.features.forEach((feature, index) => this.#addNeighbourhoodOverlay(feature, index))
      })
    } catch (error) {
      console.error("Error loading geoJSON data:", error)
    }
  }

  #addNeighbourhoodOverlay = (feature, index) => {
    this.#addCountourSourceToMap(feature)
    this.#addFillToMap(feature, index)
    this.#addOutlineToMap(feature)
  }

  #addCountourSourceToMap = (feature) => {
    this.map.addSource(feature.properties.nomreduit, {
      type: 'geojson',
      data: feature
    })
  }

  #addFillToMap = (feature, index) => {
    const colors = [
      '#F7F0F5',
      '#70E666',
      '#0F431B',
      '#4C018D',
      '#0D6EFD',
      '#FFC65A',
      '#E67E22',
      '#1EDD88',
      '#FD1015'
    ]
    this.map.addLayer({
      id: feature.properties.nomreduit,
      type: 'fill',
      source: feature.properties.nomreduit,
      layout: {},
      paint: {
        'fill-color': colors[index],
        'fill-opacity': 0.3
        }
    })
  }

  #addOutlineToMap = (feature) => {
    this.map.addLayer({
      id: feature.properties.nomreduit + '-line',
      type: 'line',
      source: feature.properties.nomreduit,
      layout: {},
      paint: {
        'line-color': '#000',
        'line-width': 1
      }
    })
  }

  showSpotDetails(event) {
    const { id } = event.currentTarget.dataset
    fetch(`/spots/${id}`, {
      headers: {
        accepts: "text/html"
      }
    }).then(response => response.text())
      .then(this.#setSpotDetails)
  }

  #setSpotDetails = (html) => {
    this.spotDetailsTarget.innerHTML = html
    setTimeout(() => {
      this.spotDetailsContentTarget.classList.add('show')
    }, 100)
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
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html
      const newMarker = new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)

      const markerHtml = newMarker.getElement()
      markerHtml.setAttribute('data-action', 'click->map#showSpotDetails')
      markerHtml.setAttribute(`data-id`, marker.id)
    })
  }
}
