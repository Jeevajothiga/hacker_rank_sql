---Write a query to print all prime numbers less than or equal to 1000 . Print your result on a single line, and use the ampersand () character as your separator (instead of a space).
--For example, the output for all prime numbers <= 10 would be: 2&3&5&7
DELIMITER **  -- Change the statement delimiter to ** to define a multi-line procedure

CREATE PROCEDURE primeNumbers()  -- Create a procedure named 'primeNumbers'
BEGIN
    DECLARE n INT DEFAULT 3;  -- Declare the starting number to check for primes (starts at 3)
    DECLARE result VARCHAR(2000) DEFAULT "2";  -- Start result string with "2" (the first prime)
    
    loop1: WHILE n<=1000 DO  -- Outer loop to check numbers from 3 to 1000
        SET @i = 2;  -- Start checking divisibility from 2
        SET @isPrime = 1;  -- Assume n is prime
        
        loop2: WHILE @i<=CEIL(n/2) DO  -- Inner loop to check divisibility from 2 to n/2
            IF n % @i = 0 THEN  -- If n is divisible by i, it's not a prime
                SET @isPrime = 0;  -- Mark n as not prime
                LEAVE loop2;  -- Stop checking further divisors
            END IF;
            
            SET @i = @i + 1;  -- Move to the next divisor
        END WHILE loop2;
        
        IF @isPrime = 1 THEN  -- If n is still marked as prime
            SET result = CONCAT(result, "&", n);  -- Add n to the result string with "&"
        END IF;
        
        SET n = n + 1;  -- Move to the next number
    END WHILE loop1;
    
    SELECT result;  -- Print the result string with all prime numbers
END**

DELIMITER ;  -- Reset the delimiter to ;

CALL primeNumbers();  -- Call the procedure to execute it
