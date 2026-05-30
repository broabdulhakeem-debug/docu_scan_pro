import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  // NOTE: Replace with your real Stripe publishable key in main initialization

  Future<void> initStripe(String publishableKey) async {
    Stripe.publishableKey = publishableKey;
    await Stripe.instance.applySettings();
  }

  /// Creates a payment sheet for subscription checkout
  Future<void> createSubscriptionPayment({
    required String customerId,
    required String ephemeralKeySecret,
    required String clientSecret,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: 'DocuScan Pro',
        customerId: customerId,
        customerEphemeralKeySecret: ephemeralKeySecret,
        paymentIntentClientSecret: clientSecret,
        style: ThemeMode.light,
        allowsDelayedPaymentMethods: false,
      ),
    );

    await Stripe.instance.presentPaymentSheet();
  }

  /// Subscription tiers logic reference
  Map<String, dynamic> getPlans() {
    return {
      "starter": {
        "price": 10,
        "pages": 100,
      },
      "professional": {
        "price": 20,
        "pages": 250,
      },
      "unlimited": {
        "price": 50,
        "pages": "unlimited",
      },
      "organization": {
        "price": 150,
        "pages": "unlimited",
        "billing": "yearly",
      }
    };
  }
}