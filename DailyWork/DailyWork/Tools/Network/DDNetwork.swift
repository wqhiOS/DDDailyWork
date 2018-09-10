//
//  DDNetwork.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/8.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON

typealias SuccessHandle = ([String:Any])->()
typealias SuccessJSONHandle = (JSON)->()
typealias FailureHandle = (Error)->()

typealias UploadProgressHandle = (Progress)->()
typealias UploadHandle = (MultipartFormData)->Void

let manager: SessionManager = {
    let configuration = URLSessionConfiguration.default
    let reachability = NetworkReachabilityManager()
    if (reachability?.isReachable)! {
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    }else
    {
        configuration.requestCachePolicy = .returnCacheDataElseLoad
    }
    return Alamofire.SessionManager(configuration: configuration)
}()


func postRequest(_ url: String,
                 parameters: Parameters,
                 success: SuccessJSONHandle?,
                 failure: FailureHandle?) {
    
    
    request(url: url, method: .post, parameters: parameters, success: success, failure: failure)
}

func getRequest(_ url: String,
                parameters: Parameters,
                success: SuccessJSONHandle?,
                failure: FailureHandle?) {
    
    request(url: url, method: .get, parameters: parameters, success: success, failure: failure)
    
}

func upload(_ url: String,
            parameter: Parameters?,
            data: Data,
            upload:@escaping UploadHandle,
            progress: UploadProgressHandle?,
            success: SuccessHandle?,
            failure: FailureHandle?) {
    
    
    Alamofire.upload(multipartFormData: upload, to: url, method: .post, headers: nil) { (multipartFormDataEncodingResult) in
        switch multipartFormDataEncodingResult {
            
        case .success(let upload, _, _):
            
            upload.responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    
                    
                    if let dict = value as? Dictionary<String,Any>, let success = success {
                        success(dict)
                    }
                    
                case .failure(let error):
                    
                    if let failure = failure {
                        failure(error)
                    }
                }
            })
            
            if let progress = progress {
                upload.uploadProgress(closure: progress)
            }
            
        case .failure(let error):
            if let failure = failure {
                failure(error)
            }
        }
    }
}

private func request(url: String,
                     method: HTTPMethod,
                     parameters: Parameters,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: HTTPHeaders? = nil,
                     success: SuccessJSONHandle?,
                     failure: FailureHandle?) {
    
    let configuration = URLSessionConfiguration.default
    let r = NetworkReachabilityManager()
    if r?.isReachable == false {
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    }else {
        configuration.requestCachePolicy = .returnCacheDataElseLoad
    }

    manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseSwiftyJSON { (response) in
        switch response.result {
        case .success(let vale):
            if let success = success {
                success(vale)
            }
        case .failure(let error):
            if let failure = failure {
                failure(error)
            }
        }
    }
        
    }

