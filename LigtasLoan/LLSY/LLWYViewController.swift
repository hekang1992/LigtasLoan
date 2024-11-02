//
//  LLWYViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/11/2.
//

import UIKit
import RxRelay
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
        
        if let url = URL(string: pageUrl.value) {
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
        print("message:\(message.body)")
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
        ViewLoadingManager.addLoadingView()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ViewLoadingManager.hideLoadingView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ViewLoadingManager.hideLoadingView()
    }
    
    private func shouldOpenInExternalApp(_ urlStr: String) -> Bool {
        return urlStr.hasPrefix("whatsapp:") || urlStr.hasPrefix("mailto:")
    }
    
    private func handleExternalURL(url: URL, urlStr: String) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else if urlStr.hasPrefix("whatsapp:") {
            ToastUtility.showToast(message: "To continue, please install WhatsApp.")
        }
    }
    
}
