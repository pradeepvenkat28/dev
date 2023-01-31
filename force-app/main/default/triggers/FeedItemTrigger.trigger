trigger FeedItemTrigger on FeedItem (after insert, after update) {

  account a = new account(name = 'feedItem');
  insert a;

}