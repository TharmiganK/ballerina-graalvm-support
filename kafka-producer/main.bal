import ballerina/log;
import ballerinax/kafka;
 
kafka:Producer kafkaProducer = check new (kafka:DEFAULT_URL);

public type Order readonly & record {|
    int id;
    string desc;
    PaymentStatus paymentStatus;
|};

public enum PaymentStatus {
    SUCCESS,
    FAIL
}

public function main() returns error? {
    Order[] orders = [
        {
            id: 11,
            desc: "description 11",
            paymentStatus: "SUCCESS"
        },
        {
            id: 12,
            desc: "description 12",
            paymentStatus: "SUCCESS"
        },
        {
            id: 13,
            desc: "description 13",
            paymentStatus: "FAIL"
        }
    ];

    log:printInfo("Sending the orders ...");
    
    foreach Order 'order in orders {
        log:printInfo(string `Sending order id : ${'order.id}`);
        check kafkaProducer->send({ topic: "orders", value: 'order });
    }
    // check kafkaProducer->'flush();
    // check kafkaProducer->close();
}