import ballerina/log;
import ballerinax/kafka;

kafka:ConsumerConfiguration consumerConfigs = {
    groupId: "success-orders-consumer",
    topics: ["success-orders"],
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

service on new kafka:Listener(kafka:DEFAULT_URL, consumerConfigs) {

    remote function onConsumerRecord(Order[] orders) returns error? {
        log:printInfo("Receiving Orders ...");
        foreach Order 'order in orders {
            log:printInfo("Received Order: " + 'order.toJsonString());
        }
    }
}