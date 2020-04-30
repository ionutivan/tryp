import Foundation

struct TripCellViewModel {
  let pilotName: String
  let pilotImageViewURL: URL?
  let pickupName: String
  let dropOffName: String
  let rating: Double
  
  init(item: Trip) {
    pilotName = item.pilot.name
    dropOffName = item.drop_off.name
    pickupName = item.pick_up.name
    pilotImageViewURL = URL(string: baseURL.appending(item.pilot.avatar))
    rating = item.pilot.rating
  }
}
