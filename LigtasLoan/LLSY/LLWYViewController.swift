//
//  LLWYViewController.swift
//  LigtasLoan
//
//  Created by LigtasLoan on 2024/11/2.
//

import UIKit
import RxRelay
import StoreKit
@preconcurrency import WebKit

class LLWYViewController: LLBaseViewController {
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.mlabel.text = "ORDER DETAILS"
        return headView
    }()
    
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let usercc = WKUserContentController()
        let jsfun = ["guitarGar", "tangerine", "jacketYam", "garlicKiw", "monkeyUgl", "mangoHibi"]
        jsfun.forEach { usercc.add(self, name: $0) }
        config.userContentController = usercc
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.bounces = false
        webView.scrollView.alwaysBounceVertical = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.navigationDelegate = self
        return webView
    }()
    
    var pageUrl = BehaviorRelay<String>(value: "")
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.tintColor = UIColor.init(cssStr: "#5AD7F3")
        progressView.trackTintColor = UIColor.init(cssStr: "#F6F7F6")
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHelper.getStatusBarHeight() + 56)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            }else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }).disposed(by: disposeBag)
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
        }
        
        webView.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        let extendedURL = LLJieURL.appendters(url: pageUrl.value, parameters: LLDLInfo.getLogiInfo()) ?? "".replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string: extendedURL) {
            webView.load(URLRequest(url: url))
        }
        
        webView.rx.observe(String.self, "title")
            .subscribe(onNext: { [weak self] title in
                DispatchQueue.main.async {
                    self?.headView.mlabel.text = title ?? ""
                }
            }).disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .map { Float($0) }
            .bind(to: progressView.rx.progress)
            .disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .filter { $0 == 1.0 }
            .subscribe(onNext: { [weak self] _ in
                self?.progressView.setProgress(0.0, animated: false)
                self?.progressView.isHidden = true
            })
            .disposed(by: disposeBag)
        
    }
    
}

extension LLWYViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message:\(message.name)")
        let name = message.name
        if name == "garlicKiw" {
            self.navigationController?.popToRootViewController(animated: true)
        } else if name == "mangoHibi" {
            topjapp()
        } else if name == "jacketYam" {
            self.navigationController?.popViewController(animated: true)
        } else if name == "guitarGar" {
            if let array = message.body as? [String] {
                locationConfig = LLLocationConfig()
                locationConfig?.startUpdatingLocation(completion: { model in
                    LLMdMessInfo.bpOInfo(from: model, proloID: array.first ?? "0", st:array.last ?? "0", jd: LLSBTwoDict.getCurrentTime(), type: "10")
                })
            }
        } else if name == "monkeyUgl" {
            if let array = message.body as? [String], let urlString = array.first {
                if urlString.hasPrefix("LigtaSloanMail://") {
                    if let range = urlString.range(of: "//") {
                        let substring = urlString[range.upperBound...]
                        if let mailURL = URL(string: "mailto:\(substring)") {
                            if UIApplication.shared.canOpenURL(mailURL) {
                                UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
                            } else {
                                
                            }
                        }
                    }
                }else {
                    if let range = urlString.range(of: "//") {
                        let phoneNumber = urlString[range.upperBound...]
                        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                            if UIApplication.shared.canOpenURL(phoneURL) {
                                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                            } else {
                                
                            }
                        }
                    }
                }
            }
        } else if name == "tangerine" {
            if let array = message.body as? [String] {
                self.genjuurltovc(from: array.first ?? "")
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        let urlStr = url.absoluteString
        if shouldOpenInExternalApp(urlStr) {
            handleExternalURL(url: url, urlStr: urlStr)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        LoadingManager.addLoadingView()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        LoadingManager.hideLoadingView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        LoadingManager.hideLoadingView()
    }
    
    private func shouldOpenInExternalApp(_ urlStr: String) -> Bool {
        return urlStr.hasPrefix("whatsapp:") || urlStr.hasPrefix("mailto:")
    }
    
    private func handleExternalURL(url: URL, urlStr: String) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else if urlStr.hasPrefix("whatsapp:") {
            ToastViewConfig.showToast(message: "To continue, please install WhatsApp.")
        }
    }
    
    private func topjapp() {
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
    }
    
}
