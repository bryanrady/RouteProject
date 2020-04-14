/*
 * Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package android.database.sqlite;

import android.database.CursorWindow;
import android.database.DatabaseUtils;
import android.os.CancellationSignal;
import android.os.OperationCanceledException;
import android.os.ParcelFileDescriptor;

/**
 * Provides a single client the ability to use a database.
 *
 * <h2>About database sessions</h2>
 * <p>
 * Database access is always performed using a session.  The session
 * manages the lifecycle of transactions and database connections.
 * </p><p>
 * Sessions can be used to perform both read-only and read-write operations.
 * There is some advantage to knowing when a session is being used for
 * read-only purposes because the connection pool can optimize the use
 * of the available connections to permit multiple read-only operations
 * to execute in parallel whereas read-write operations may need to be serialized.
 * </p><p>
 * When <em>Write Ahead Logging (WAL)</em> is enabled, the database can
 * execute simultaneous read-only and read-write transactions, provided that
 * at most one read-write transaction is performed at a time.  When WAL is not
 * enabled, read-only transactions can execute in parallel but read-write
 * transactions are mutually exclusive.
 * </p>
 *
 * <h2>Ownership and concurrency guarantees</h2>
 * <p>
 * Session objects are not thread-safe.  In fact, session objects are thread-bound.
 * The {@link SQLiteDatabase} uses a thread-local variable to associate a session
 * with each thread for the use of that thread alone.  Consequently, each thread
 * has its own session object and therefore its own transaction state independent
 * of other threads.
 * 