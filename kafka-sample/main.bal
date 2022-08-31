import ballerina/log;
import ballerinax/kafka;

string groupId = "order-consumers";
string orders = "orders";
string paymentSuccessOrders = "payment-success-orders";
decimal pollingInterval = 1;
string kafkaEndpoint = kafka:DEFAULT_URL;

public type Order readonly & record {|
    int id;
    string desc;
    PaymentStatus paymentStatus;
|};

public enum PaymentStatus {
    SUCCESS,
    FAIL
}

final kafka:ConsumerConfiguration consumerConfigs = {
    groupId: groupId,
    topics: [orders],
    offsetReset: kafka:OFFSET_RESET_EARLIEST,
    pollingInterval: pollingInterval
};

service on new kafka:Listener(kafkaEndpoint, consumerConfigs) {
    private final kafka:Producer orderProducer;

    function init() returns error? {
        self.orderProducer = check new (kafkaEndpoint);
    }

    remote function onConsumerRecord(Order[] orders) returns error? {
        log:printInfo("Sending successful orders ...");
        check from Order 'order in orders
            where 'order.paymentStatus == SUCCESS
            do {
                log:printInfo(string `Sending order id : ${'order.id}`);
                check self.orderProducer->send({
                    topic: paymentSuccessOrders,
                    value: 'order
                });
            };
    }
}
