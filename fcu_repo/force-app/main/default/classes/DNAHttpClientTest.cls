@isTest
public class DNAHttpClientTest {
    
    @isTest
    public static void testGetApiMethod(){
        DNAHttpClientMockTest mockResp = new DNAHttpClientMockTest(200,'Success','{}',null);
        Test.setMock(HttpCalloutMock.class, mockResp);
        Test.startTest();
        DNAHttpClient.getAPI('google.com');
        DNAHttpClient.CallDNAAPI('google.com','{}','POST');
        Test.stopTest();
    }

}