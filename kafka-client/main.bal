import ballerinax/kafka;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfiguration = {
    groupId: "success-orders-consumer",
    topics: ["payment-success-orders"],
    offsetReset: kafka:OFFSET_RESET_EARLIEST,
    pollingInterval: 1
};

public type Order readonly & record {|
    int id;
    string desc;
    PaymentStatus paymentStatus;
|};

public enum PaymentStatus {
    SUCCESS,
    FAIL
}

kafka:Consumer orderConsumer = check new (kafka:DEFAULT_URL, consumerConfiguration);

public function main() returns error? {
    log:printInfo("Receiving Orders ...");

    Order[] orders = check orderConsumer->pollPayload(1);

    foreach Order 'order in orders {
        log:printInfo("Received Order: " + 'order.toJsonString());
    }
}
