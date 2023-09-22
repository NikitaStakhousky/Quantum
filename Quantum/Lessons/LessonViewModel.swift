//
//  LessonViewModel.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 26.07.2023.
//

import Foundation
import StoreKit

  final class LessonViewModel: ObservableObject {
    var model: [Lesson] = [
      Lesson(img: "http://65.108.243.149/1/image6.jpg", text: "Trading on the stock market involves buying and selling shares of publicly traded companies. To start trading, you will need to open a brokerage account and deposit funds. Once your account is set up, you can begin researching and selecting stocks to trade. There are many tools and resources available to help you analyze market trends and make informed decisions about which stocks to buy and sell.When you are ready to make a trade, you can place an order through your broker, who will execute the trade on your behalf. There are several types of orders you can use, including market orders, limit orders, and stop-loss orders. It is important to understand the differences between these order types and how they can affect your trades.It is also important to monitor your investments regularly and adjust your strategy as needed. This may involve selling stocks that are underperforming or buying more shares of a stock that is doing well. Many traders use technical analysis to help them make decisions about when to buy and sell.In summary, trading on the stock market involves opening a brokerage account, researching and selecting stocks, placing orders through a broker, and monitoring your investments. It is important to educate yourself about the markets and develop a strategy that works for you.", lessontitle: "Lesson 2", lessonPreview: "How to Trade on the Stock Market?"),
      Lesson(img: "http://65.108.243.149/1/image7.jpg", text: "The global economic system refers to the interconnected network of economies around the world. This system is influenced by factors such as trade, investment, and the movement of goods, services, and capital across borders. The global economic system is complex and dynamic, with many different players, including governments, businesses, and international organizations.One of the key features of the global economic system is the use of international trade to exchange goods and services between countries. This allows countries to specialize in certain industries and export their products to other countries, while importing goods that they need from other countries. International trade is facilitated by agreements between countries, such as free trade agreements, which reduce barriers to trade.Another important aspect of the global economic system is the flow of investment between countries. This can take many forms, including foreign direct investment, where a company invests in a business in another country, or portfolio investment, where an investor buys stocks or bonds issued by a foreign company. Investment flows can help to stimulate economic growth and development in countries around the world.The global economic system is constantly evolving, with new technologies and trends shaping its development. For example, the rise of digital technologies has made it easier for businesses to operate globally and has increased the importance of cross-border data flows. At the same time, there are challenges facing the global economic system, such as income inequality and environmental degradation.In summary, the global economic system is a complex network of economies that are interconnected through trade, investment, and other factors. It is constantly evolving and presents both opportunities and challenges for countries around the world.", lessontitle: "Lesson 3", lessonPreview: "The Global Economic System"),
      Lesson(img: "http://65.108.243.149/1/image8.jpg", text: " Cryptocurrencies are digital or virtual currencies that use cryptography for security and operate independently of a central bank. They are decentralized systems based on blockchain technology, which is a distributed ledger enforced by a network of computers. The first and most well-known cryptocurrency is Bitcoin, which was created in 2009 by an anonymous individual or group using the pseudonym Satoshi Nakamoto.Since the creation of Bitcoin, thousands of other cryptocurrencies have been developed, each with their own unique features and uses. Some of the most popular cryptocurrencies include Ethereum, Ripple, and Litecoin. Cryptocurrencies can be used for a variety of purposes, including as a medium of exchange, a store of value, and as a unit of account.One of the key features of cryptocurrencies is their decentralized nature, which means that they are not controlled by any government or financial institution. This allows for greater privacy and freedom in transactions, as well as the potential for lower transaction fees. However, the lack of regulation also means that there is a higher risk of fraud and other illegal activities.The value of cryptocurrencies can be highly volatile, with prices fluctuating rapidly in response to market conditions and news events. This makes them a risky investment, but also presents opportunities for traders to profit from price movements.In summary, cryptocurrencies are digital currencies that use cryptography for security and operate independently of central banks. They are decentralized systems based on blockchain technology and can be used for a variety of purposes. While they offer many benefits, they also carry risks and should be approached with caution.", lessontitle: "Lesson 4", lessonPreview: "Cryptocurrencies"),
      Lesson(img: "http://65.108.243.149/1/image1.jpg", text: "Soon", lessontitle: "Lesson 5", lessonPreview: "lesson coming soon 10.10.2023"),
      Lesson(img: "http://65.108.243.149/1/image2.jpg", text: "Soon", lessontitle: "Lesson 6", lessonPreview: "lesson coming soon 20.10.2023"),
      Lesson(img: "http://65.108.243.149/1/image3.jpg", text: "Soon", lessontitle: "Lesson 7", lessonPreview: "lesson coming soon 30.10.2023")]
    
    private let networkService = NetworkService()
    private let productIds = ["lesson_2", "lesson_3", "lesson_4", "lesson_5", "lesson_6", "lesson_7"]
    
    @Published
    private(set) var products: [Product] = []
    private var productsLoaded = false
    @Published
    private(set) var purchasedProductIDs = Set<String>()
    private var updates: Task<Void, Never>? = nil
    
    var hasUnlockedPro: Bool {
      return !self.purchasedProductIDs.isEmpty
    }
    init() {
      updates = observeTransactionUpdates()
    }
    
    deinit {
      updates?.cancel()
    }
    
//    func getData() {
//      networkService.getData { lesson in
//        DispatchQueue.main.async {
//          self.model = lesson
//        }
//      }
//    }
    
      @MainActor
    func updatePurchasedProducts() async {
      for await result in Transaction.currentEntitlements {
        guard case .verified(let transaction) = result else {
          continue
        }
        
        if transaction.revocationDate == nil {
          self.purchasedProductIDs.insert(transaction.productID)
        } else {
          self.purchasedProductIDs.remove(transaction.productID)
        }
      }
    }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
      Task(priority: .background) { [unowned self] in
        for await verificationResult in Transaction.updates {
          await self.updatePurchasedProducts()
        }
      }
    }
    @MainActor
    func loadProducts() async throws {
      guard !self.productsLoaded else { return }
      self.products = try await Product.products(for: productIds)
        print(productIds)
      self.productsLoaded = true
    }
    
    func purchase(_ product: Product) async throws {
      let result = try await product.purchase()
      
      switch result {
      case let .success(.verified(transaction)):
        await self.updatePurchasedProducts()
        await transaction.finish()
      case let .success(.unverified(_, error)):
        break
      case .pending:
        break
      case .userCancelled:
        break
      @unknown default:
        break
      }
    }
  }

