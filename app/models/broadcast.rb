class Broadcast
  VALID_EVENTS = ["NewVideo", "NewAnnouncement"]

  attr_accessor :broadcastable, :event, :headline, :url, :users

  # @param [Hash] options
  # @param [Hash] options [ApplicationRecord] broadcastable The resource which triggered this broadcast. The focus of attention.
  # @param [Hash] options [String] event The type of event that triggered this broadcast.
  # @param [Hash] options [String] headline The notification headline a user will see in their inbox.
  # @param [Hash] options [String] url An optional url to redirect a user who clicks on the notification headline in their inbox.
  # @param [Hash] options [Array<User>] users A list of users to be notified.
  #
  # @example
  #
  #   Broadcast.new({
  #     broadcastable: <Video>,
  #     event: "NewVideo",
  #     headline: "Talenti Pro posted a new video. Watch it now!",
  #     users: [<User>, <User>, <User>]
  #   }).perform
  #
  def initialize(options = {})
    @broadcastable = options[:broadcastable]
    @event = options[:event]
    @headline = options[:headline]
    @url = options[:url]
    @users = options[:users]
    validate
  end

  def perform
    notification = Notification.create(broadcastable: broadcastable, event: event, headline: headline, url: url)
    UserNotification.create(users.map{|user| {user: user, notification: notification, marked_read: false} })
  end

private

  def validate
    validate_broadcastable
    validate_event
    validate_event_and_broadcastable
    validate_headline
    validate_users
  end

  def validate_broadcastable
    raise ArgumentError.new("Broadcastable must be a valid resource") unless broadcastable.class < ApplicationRecord
  end

  def validate_event
    raise ArgumentError.new("Event must be one of: #{VALID_EVENTS}") unless VALID_EVENTS.include?(event)
  end

  def validate_event_and_broadcastable
    case event
    when "NewVideo"
      raise ArgumentError.new("Broadcastable must match event type") unless broadcastable.class == Video
    when "NewAnnouncement"
      raise ArgumentError.new("Broadcastable must match event type") unless broadcastable.class == Announcement
    else
      raise StandardError.new("OOPS. THAT EVENT IS NOT YET REGISTERED.")
    end
  end

  def validate_headline
    raise ArgumentError.new("Headline must be present") unless headline
  end

  def validate_users
    raise ArgumentError.new("Users must be users") unless [User::ActiveRecord_Associations_CollectionProxy, User::ActiveRecord_Relation].include?(users.class)
  end
end
