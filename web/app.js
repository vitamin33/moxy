function fbqAddToCartEvent(productName) {
    fbq('track', 'AddToCart', {
        content_name: productName,
    });
}

function fbqAddToWishlistEvent(productName) {
    fbq('track', 'AddToWishlist', {
        content_name: productName,
    });
}

function fbqCompleteRegistrationEvent() {
    fbq('track', 'CompleteRegistration');
}

function fbqInitiateCheckoutEvent() {
    fbq('track', 'InitiateCheckout');
}

function fbqLeadEvent(leadEmail) {
    fbq('track', 'Lead', { value: leadEmail });
}

function fbqPurchaseEvent(valuePurchuase) {
    fbq('track', 'Purchase', { currency: "UAH", value: valuePurchuase, });
} 
