module Migrator
  mattr_accessor :offer_migration_when_available
  @@offer_migration_when_available = true

  class << self
    def migrations_path
      "#{RAILS_ROOT}/db/migrate"
    end

    def available_migrations
      Dir["#{migrations_path}/[0-9]*_*.rb"].sort_by { |name| name.scan(/\d+/).first.to_i }
    end

    def current_schema_version
      ActiveRecord::Migrator.current_version rescue 0
    end

    def max_schema_version
      parse_migrations(available_migrations, :version).max
    end

    def db_supports_migrations?
      ActiveRecord::Base.connection.supports_migrations?
    end

    def migrate(version = nil)
      ActiveRecord::Migrator.migrate("#{migrations_path}/", version)
    end

    def need_db_updates?
      offer_migration_when_available && current_schema_version < max_schema_version 
    end

    def pending_migrations
      available_migrations.reject do |m| 
        already_migrated.include? parse_migration(m, :version)
      end
    end

    def human_pending_migrations
      pending_migrations.collect do |mig|
        mig.scan(/\d+\_([\w_]+)\.rb$/).flatten.first.humanize
      end
    end

    private

    def already_migrated
      ActiveRecord::Migrator.get_all_versions
    end

    def parse_migration(m, attr)
      version, name = m.scan(/([0-9]+)_([_a-z0-9]*).rb/).first 
      attr == :version ?  version.to_i : name
    end

    def parse_migrations(col,attr)
      col.collect {|m| parse_migration(m,attr)}
    end

  end
end
