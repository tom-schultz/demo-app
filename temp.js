var response = require('cfn-response');
var AWS = require('aws-sdk');
AWS.config.update({region: 'us-west-2'});

exports.handler = (event, context) => {
  console.log("Request received:\n", JSON.stringify(event));
  var physicalId = event.PhysicalResourceId || 'none';
  var success = data => response.send(event, context, response.SUCCESS, data, physicalId);
  var failed = e => response.send(event, context, response.FAILED, e, physicalId);
  if (event.RequestType == 'Create' || event.RequestType == 'Update') {
    var alb = new AWS.ELBv2();
    alb.describeTargetHealth({TargetGroupArn: "arn:aws:elasticloadbalancing:us-west-2:950174139509:targetgroup/tamcorp-demo-test/39bb55a0948f263c"},
      function(err, data) {
        if(err) {
          failed(err);
        } else {
          has_failed = false;
          data.TargetHealthDescriptions.forEach(function(element) {
            if(element.TargetHealth.State != 'healthy') {
              has_failed = true;
            }
          });

          if(!has_failed) {
            success(data);
            return;
          }

          failed(data);
        }
    });
  } else {
    success({});
  }
};

exports.handler({RequestType: 'Update'}, {});
