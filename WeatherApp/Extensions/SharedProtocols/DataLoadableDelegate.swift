//
//  DataLoadableDelegate.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 21/03/2024.
//

import Foundation

protocol DataLoadableDelegate: AnyObject {
    @MainActor func didUpdateWeatherData()
    @MainActor func handleError(_ errorDescription: String?)
    @MainActor func handleLoading(_ shouldBeShown: Bool)
    @MainActor func handleTitleError(shouldBeShown: Bool, _ errorMessage: String)
}

extension DataLoadableDelegate {
    @MainActor func fetchData<ResponseData, RequestData>(data: RequestData,
                                                         with method: (RequestData) async throws -> ResponseData,
                                                         successAction: (@MainActor (_ data: ResponseData) async -> Void)? = nil) async {
        defer { handleLoading(false) }
        handleLoading(true)
        do {
            let response = try await method(data)
            if let successAction {
                await successAction(response)
            }
        } catch let NetworkError.apiError(errorMessage) {
            handleError(errorMessage?.getErrorMessage())
        } catch {
            handleError(error.localizedDescription)
        }
    }
    
    @MainActor func fetchData<ResponseData>(with method: () async throws -> ResponseData,
                                            successAction: (@MainActor (_ data: ResponseData) async -> Void)? = nil) async {
        defer { handleLoading(false) }
        handleLoading(true)
        do {
            let response = try await method()
            if let successAction {
                await successAction(response)
            }
        } catch let NetworkError.apiError(errorMessage) {
            handleError(errorMessage?.getErrorMessage())
        } catch {
            handleError(error.localizedDescription)
        }
    }
}
