import Foundation

class GeonamesApiManager
{
    var delegate : GeonamesApiDelegate?
    let baseURL = "http://api.geonames.org/searchJSON?"
    let username = "maylcf" // Change to your username
    let maxRows = 15
    
    func getCitiesByName(cityName : String)
    {
        if let myUrl = getNameSearchUrl(searchText: cityName)
        {
            DispatchQueue.main.async
            {
                do
                {
                    let dataFromUrl = try String(contentsOf: myUrl, encoding: String.Encoding.utf8)
                    let data = dataFromUrl.data(using: .utf8)!
                    let json = JSON(data)
                    let jsonArray = json["geonames"].array
                    
                    DispatchQueue.main.async
                    {
                        if let jsonArray = jsonArray
                        {
                            self.delegate?.didFinishWithData(result: jsonArray)
                        }
                        else
                        {
                            self.delegate?.didFinishWithData(result: [JSON]())
                        }
                    }
                }
                catch
                {
                    print(error)
                }
            }
        }
    }
    
    func getNameSearchUrl(searchText: String) -> URL?
    {
        let baseUrl = getBaseSearchString(searchText: searchText)
        print("NewCityURL = \(baseUrl)")
        return UrlManager.getUrl(text: baseUrl)
    }

    func getNameAndCountrySearchUrl(searchText: String, countryCode: String) -> URL?
    {
        let baseUrl = getBaseSearchString(searchText: searchText)
        let completeUrl = baseUrl + "&country=\(countryCode)"
        //print("NewCityURL = \(completeUrl)")
        return UrlManager.getUrl(text: completeUrl)
    }
    
    func getBaseSearchString(searchText: String) -> String
    {
        let city = "name_startsWith=\(searchText)"
        let rows = "&maxRows=\(self.maxRows)"
        let user = "&username=\(self.username)"
        let code = "&cities=cities1000"
        
        return self.baseURL + city + rows + code + user
    }
}

protocol GeonamesApiDelegate
{
    func didFinishWithData(result : [JSON]);
}
