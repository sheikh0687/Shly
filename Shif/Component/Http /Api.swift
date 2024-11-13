//
//  Api.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 20/10/23.
//

import Foundation

class Api: NSObject {
    
    static let shared = Api()
    
    private override init(){}
    
    func paramGetUserId() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.string(forKey: k.session.userId) as AnyObject
        print(dict)
        return dict
    }
    
    func login(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResLogin) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.login.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Login.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.hideProgressBar()
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.type)
                    k.userDefault.set(k.emptyString, forKey: k.session.userName)
                    k.userDefault.set(k.emptyString, forKey: k.session.customerId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userMobile)
                    k.userDefault.set(k.emptyString, forKey: k.session.mobileWithCode)
                    vc.alert(alertmessage: "Identifiant ou Mot de passe incorrect")
//                    if self.language == "english" {
//                        vc.alert(alertmessage: root.message ?? "Something Went Wrong")
//                    } else {
//                        vc.alert(alertmessage: "Identifiant ou Mot de passe incorrect")
//                    }
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func WebForgetPassword(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.forgotPassword.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func signup(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResLogin) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.signup.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Login.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.hideProgressBar()
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.userName)
                    k.userDefault.set(k.emptyString, forKey: k.session.type)
                    k.userDefault.set(k.emptyString, forKey: k.session.customerId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userMobile)
                    k.userDefault.set(k.emptyString, forKey: k.session.mobileWithCode)
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong")
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getProfile(_ vc: UIViewController, _ success: @escaping(_ responseData : Res_Profile) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getProfile.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Profile.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func updateLocation(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData : Res_Profile) -> Void) {
        vc.blockUi()
        Service.post(url: Router.updateLocation.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Profile.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getCategory(_ vc: UIViewController, _ success: @escaping(_ responseData : [Res_Category]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getCategory.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Category.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getBannerImage(_ vc: UIViewController, _ success: @escaping(_ responseData : [Res_Banner]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getBannerImg.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_BannerList.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getServiceFilter(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : [Res_ServiceFilter]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getServiceFilter.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ServiceFilter.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getServiceDetails(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : Res_ProviderServiceDt) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getServiceDetail.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ProviderServiceDt.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getProviderDetail(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : Res_ProviderDeatil) -> Void) {
        vc.blockUi()
        Service.post(url: Router.getProviderDetail.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ProviderDetail.self, from: response)
                if let result = root.result {
                    success(result)
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getProviderService(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : [Res_ServiceList]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getProviderService.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ServiceList.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getProviderReviews(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : [Res_ProviderDetail]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getProviderReview.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ProviderReview.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getBookingStatus(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : [Res_BookingStatus]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getBookingStatus.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_BookingStatus.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getConversation(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : [Res_Conversation]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getConversation.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Conversation.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func get_NotificationList(_ vc: UIViewController,_ success: @escaping(_ responseData : [Res_Notification]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getNotificationList.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Notification.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func user_Chat(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : [Res_Chats]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getChats.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Chats.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getAddress(_ vc: UIViewController,_ success: @escaping(_ responseData : [Res_Address]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getAddress.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Address.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getTimeSlot(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : [Res_TimeSlot]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getTimeSlot.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_TimeSlot.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
        print("esacaping Closure will execute later first function will end or return")
    }
    
    func addRating(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : Res_AddRating) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.addRating.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Rating.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func addAddress(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : Res_AddAddress) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.addAddress.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_AddAddress.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func addBooking(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : Res_AddBooking) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.addBooking.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_AddBooking.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func updateProfile(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : Res_Profile) -> Void) {
        vc.showProgressBar()
        Service.postSingleMedia(url: Router.updateProfile.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Profile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something went wrong")
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func change_Password(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Res_ChangePassword) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.changePassword.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ChangePassword.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    
    func deleteAddress(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.deleteAddress.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func deleteUserAccount(_ vc: UIViewController,_ success: @escaping(_ responseData : Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.deleteUserAccount.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func stripePayment(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : AnyObject) -> Void) {
        vc.blockUi()
        Service.callPostService(apiUrl: Router.stripePayment.url(), parameters: params, Method: .get, parentViewController: vc, successBlock: { (response, message) in
            success(response)
            vc.unBlockUi()
        }) { (error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func retrieve_Card(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : Res_RetrieveCard) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.retrieveCard.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_RetriveCard.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func add_Card(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : AnyObject) -> Void) {
        vc.blockUi()
        Service.callPostService(apiUrl: Router.save_Card.url(), parameters: params, Method: .get, parentViewController: vc, successBlock: { (response, message) in
            success(response)
            vc.unBlockUi()
        }) { (error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func delete_SavedCard(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : AnyObject) -> Void) {
        vc.blockUi()
        Service.callPostService(apiUrl: Router.delete_Card.url(), parameters: params, Method: .get, parentViewController: vc, successBlock: { (response, message) in
            success(response)
            vc.unBlockUi()
        }) { (error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    
    func verifyOtp(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResOtp) -> Void) {
        vc.blockUi()
        Service.post(url: Router.otp.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiVerifyOtp.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getUserPlace(_ vc: UIViewController,_ success: @escaping(_ responseData : Res_TermAndCondition) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.userPage.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_TermsAndCondition.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    
    /// Provider SIde
    
    func getSubCategory(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : [Res_SubCategory]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getSubCategory.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_SubCategory.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getGallerImages(_ vc: UIViewController,_ success: @escaping(_ responseData : [Res_GallaryImage]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getGalleyImage.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_GallaryImage.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getProviderBookingStatus(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData : [Res_ProoviderBookingStatus]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getProviderBookStatus.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ProoviderBookingStatus.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getProviderTotalEarning(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData : Api_ProviderTotalEarning) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getProviderEarning.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ProviderTotalEarning.self, from: response)
                if let result = root.result {
                    success(root)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getRequestDetails(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData : Res_RequestDt) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getRequestDetail.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_RequestDetail.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func withdrawRequest(_ vc: UIViewController,_ success: @escaping(_ responseData : Res_WithdrawRequest) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getWithdrawRequest.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_WithdrawRequest.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func changeRequestStatus(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : Res_ChangeStatus) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.changeStatus.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ChangeStatus.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func addServices(_ vc: UIViewController, _ params: [String: String], images: [String : Array<Any>?]?, videos: [String : Array<Any>?]?, _ success: @escaping(_ responseData : Res_AddService) -> Void) {
        vc.showProgressBar()
        Service.postWithMedia(url: Router.addServices.url(), params: params, imageParam: images, videoParam: videos, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_AddService.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something went wrong")
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func addGalleryImg(_ vc: UIViewController, _ params: [String: String], images: [String : Array<Any>?]?, videos: [String : Array<Any>?]?, _ success: @escaping(_ responseData : Api_GallaryImage) -> Void) {
        vc.showProgressBar()
        Service.postWithMedia(url: Router.addGalleryImg.url(), params: params, imageParam: images, videoParam: videos, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_GallaryImage.self, from: response)
                if root.status == "1" {
                    success(root)
                    vc.hideProgressBar()
                } else {
                    vc.alert(alertmessage: root.message ?? "Something went wrong")
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func addChat(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : Res_InsertChat) -> Void) {
        vc.showProgressBar()
        Service.postSingleMedia(url: Router.addChat.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_InsertChat.self, from: response)
                if root.status == "1" {
                    vc.hideProgressBar()
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.hideProgressBar()
                    //                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func add_Wallet_Request(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Res_WalletRequest) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.addWalletReq.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_WalletRequest.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func updateService(_ vc: UIViewController, _ params: [String: String], images: [String : Array<Any>?]?, videos: [String : Array<Any>?]?, _ success: @escaping(_ responseData : Res_UpdateService) -> Void) {
        vc.showProgressBar()
        Service.postWithMedia(url: Router.updateService.url(), params: params, imageParam: images, videoParam: videos, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_UpdateService.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something went wrong")
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func updatedProviderProfile(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : Res_ProviderDeatil) -> Void) {
        vc.showProgressBar()
        Service.postSingleMedia(url: Router.updateProviderProfile.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ProviderDetail.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                    vc.hideProgressBar()
                } else {
                    vc.hideProgressBar()
                    //                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func deleteService(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData : Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.deleteService.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func deleteGalleryImg(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData : Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.deleteGalleryImg.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func contactUs(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Res_Contact) -> Void) {
        vc.blockUi()
        Service.post(url: Router.contact_Us.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_MakeContact.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        vc.unBlockUi()
                        success(result)
                    }
                } else {
                    vc.unBlockUi()
                    vc.alert(alertmessage: root.message ?? "")
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
}
